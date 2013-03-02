class NotesController < ApplicationController
  before_filter :load_data

  # GET /notes
  # GET /notes.xml

  def index

    options = Hash.new

    if not session[:filter].nil? and params[:filter].nil?
      params[:filter] = session[:filter].downcase
    end
    if not session[:limit].nil? and params[:side_tab_period].nil?
      params[:side_tab_period] = session[:limit]
    end

    period          = side_tabs_for_periods(:notes)
    session[:limit] = params[:side_tab_period]

    options.merge!(period)
    @count = Note.order("notes.created_at DESC").search(options).group("parent_type").count

    options.merge!(filters_for_associations(:notes))

    if not @parent_id.blank? and not @parent_name.blank?
      options.delete :created_at_gt
      options.delete :parent_type_contains_any
      options[:parent_type_equals] = @parent_name
      options[:parent_id_equals]   = @parent_id
    elsif @parent_id.nil? and params[:filter].nil?
      options[:parent_type_equals] = @parent_name
    elsif params[:filter].nil?
      options[:parent_type_equals] = @parent_name
      options[:parent_id_equals]   = @parent_id
    end

    if params[:filter]== 'note-type' or params[:filter]== 'posted-by'
      options[:parent_type_equals] = @parent_name
      options[:parent_id_equals]   = @parent_id
    end

    if options.nil?
      @notes = Note.order("notes.created_at DESC").paginate(:per_page=>Note.per_page, :page=>params[:page])
    else
      if params[:thick] == "true"
        @notes = Note.order("created_at DESC").limit(3).search(options).paginate(:per_page=>Note.per_page, :page=>params[:page])
      else
        @notes = Note.order("notes.created_at DESC").search(options).paginate(:per_page=>Note.per_page, :page=>params[:page])
      end
    end

    respond_to do |format|
      format.html # index.html.erb

      format.js do
        if params[:thick] == true
          render :partial => "shared/notes_list", :locals => {:notes=>@notes}
        else
          @show_record_count = true
          render :partial => "shared/notes_list", :locals => {:notes=>@notes}
        end

      end
      format.json do
        @show_record_count = true
        @list              = render_to_string(:partial => "shared/notes_list.html.erb", :locals=>{:notes=>@notes})
        @filter            = render_to_string(:partial => "notes_filter.html.erb")
        @selector          = render_to_string(:partial=>"selector.html.erb")
        render :json => {
            :list     => @list,
            :filter   => @filter,
            :selector => @selector
        }
      end
      format.xml { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @form_to_render   = "form_1"
    @note             = Note.new
    @note.parent_type =@parent_name
    @note.parent_id   =@parent_id
    @note.detail_type = 'NoteGeneral'
    @note.detail      = NoteGeneral.new
    if params[:type_id].present?
      @form_to_render = "form_2"

      unless @type_id.nil?
        @note.note_type_id = @type_id
        t                  = NoteType.find(@type_id)
        if (t.class_name.nil?)
#          @note.detail_type = 'XDocGeneral'
#          @note.detail      = XDocGeneral.new
        else
          @note.detail_type = t.class_name
          @note.detail      = t.class_name.constantize.new
        end
      end
    else
      @form_to_render = "form_1"
    end
    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml { render :xml => @note }
    end

  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  # POST /notes
  # POST /notes.xml
  def create
    detail = params[:note][:detail_type].constantize.new(params[:note][:detail_attributes])
    params[:note].delete(:detail_attributes)
    @note        = Note.new(params[:note])
    @note.detail = detail

    respond_to do |format|
      if @note.save
        #format.html { redirect_to(@note, :notice => 'X doc was successfully created.') }
        format.js
        format.xml { render :xml => @note, :status => :created, :location => @note }
      else
        #format.html { render :action => "new" }
        format.js
        format.xml { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.js {}
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to(notes_url) }
      format.xml { head :ok }
    end
  end

  private
  def load_data

    @show_parent = params[:show_parent] || false

    if request.fullpath.split("?")[0] == "/notes"
      @parent_name = ''
      @parent      = ''
      @parent_id   = ''
      @types       = NoteType.all
      @type_id     = nil
      if params[:type_id]
        @type_id = params[:type_id]
      end
    else
      @parent_name = request.fullpath.split('/')[1].classify
      @parent      = @parent_name.constantize
      @parent_id   = request.fullpath.split('/')[2]
      @types       = NoteType.all
      @type_id     = nil
      if params[:type_id]
        @type_id = params[:type_id]
      end
    end
  end
end
