require 'middleman-core'

class PlainHaml < Middleman::Extension
  def initialize(app, options_hash={}, &block)
    super
  end

  def manipulate_resource_list(resources)
    resources.each do |resource|
      next unless resource.source_file.end_with?('.haml')
      resource.destination_path << '.html'
    end
  end
end

::Middleman::Extensions.register(:plain_haml, PlainHaml)
