# references.rb: jekyll markdown references plugin
#
# Get it from: https://gist.github.com/olov/961336
#
# CHANGES
# 2013-05-06: Updated to support Jekyll 1.0
#             (still works with older Jekyll versions)
#
# add this file to your _plugins directory (create it if needed)
# create a file (exactly) named _references.md in your Jekyll site root,
# then add your markdown reference-style link definitions to it.
# for example:
#   [jsshaper]: http://jsshaper.org  "an extensible framework for JavaScript syntax tree shaping"
#
# you can now reference these links in any markdown file
# for example:
#   You should [check out JSShaper][jsshaper]

module Jekyll
  module Convertible
    alias old_read_yaml read_yaml
    @@refs_content = nil

    def read_yaml(base, name)
      # loads file, sets @content, @data
      old_read_yaml(base, name)

      # only alter markdown files
      md_class = ((defined? MarkdownConverter) ? MarkdownConverter : Jekyll::Converters::Markdown)
      return unless converter.instance_of? md_class

      # read and cache content of _references.md
      if @@refs_content.nil?
        refs_path = File.join(site.source, "_references.md")
        @@refs_content = if File.exist?(refs_path) then File.read(refs_path) 
                         else "" end
      end

      # append content of _references.md, whatever it is
      @content += "\n" + @@refs_content
    end
  end
end
