# To change this template, choose Tools | Templates
# and open the template in the editor.

module Atlantis
  class Rake
    class << self
      def call(task, options={})
        options[:rails_env] = Rails.env
        args = options.map { |n,v| "#{n.to_s.upcase}='#{v}"}
        system "rake #{task} #{args.join(' ')} --trace >> #{Rails.root}/log/rake.log &"
      end
    end
  end
end
