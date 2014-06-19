require 'kramdown/parser/base'
require 'kramdown/parser/kramdown'

class Kramdown::Parser::DKMramdown < Kramdown::Parser::Kramdown

  def initialize(source, options)
    super
    @block_parsers.unshift(:asides)
    @block_parsers.unshift(:adoc_aside)
    #@span_parsers.unshift(:cite)
  end

  ASIDES_START = /\(\[([^\]]*)\]/
  ASIDE_MATCH = /\(\[([^\]]*)\]\s*([^\)]*)\)\s*$/m
  ASIDE_END = /^[^\)]*\)\s*$/
  #ASIDE_END = /^\)\s*$/

  def parse_asides
    if @src.scan(ASIDE_MATCH)
      title = @src[1]
      start_line_number = @src.current_line_number
      #while !@src.match?(self.class::ASIDE_END)
      #  result << @src.scan(ASIDE_MATCH)
      #end
    
      el = new_block_el(:aside, @src[2], nil, :location => start_line_number)
      @tree.children << el
      hel = new_block_el(:header, nil, nil, :level => 1, :raw_text => title, :location => start_line_number+1)
      add_text(title, hel)
      @tree.children.last.children << hel
      parse_blocks(el, @src[2] + "\n")
      true
    else
      false
    end
  end
  define_parser(:asides, ASIDES_START)

  ADOC_BLOCK_TITLE = /^(?:\..*?\n)?\*{4}\n/
  ADOC_ASIDE_START = /^(?:\..*?\n)?\*{4,}/
  ADOC_ASIDE_MATCH = /^(?:\.(.*?)\n)?(\*{4})\n(.*?)\n^\2/m
  
  def parse_adoc_aside
    if @src.check(self.class::ADOC_ASIDE_MATCH)
      start_line_number = @src.current_line_number 
      @src.pos += @src.matched_size
      el = new_block_el(:aside, @src[3], nil, :location => start_line_number)
      @tree.children << el
      if @src[1]
        hel = new_block_el(:header, nil, nil, :level => 1, :raw_text => @src[1], :location => start_line_number+1)
        add_text(@src[1], hel)
        @tree.children.last.children << hel
      end
      parse_blocks(el, @src[3] + "\n")
   else
      false
    end
  end
  define_parser(:adoc_aside, ADOC_ASIDE_START)

  CITE_MATCH = /\s+--\s*(\w+[^-]*)$/

  def parse_cite
    #return false if !after_block_boundry?
    
    start_line_number = @src.current_line_number
    text = @src[1]
    text.strip!
    el = Element.new(:cite, nil, nil, :location => start_line_number)
    $stderr.puts "Adding cite -- #{text}"
    sleep(1)
#add_text(text, el)
    @tree.children << el
  end
  define_parser(:cite, CITE_MATCH, '\n')
end

require 'kramdown/converter/base'

module Kramdown::Converter
  class Html < Base
    def convert_aside(el, indent)
      if el.options[:transparent]
        inner(el, indent)
      else
        format_as_block_html(el.type, el.attr, inner(el, indent), indent)
      end
    end

    def convert_header(el, indent)
      if el.options[:transparent]
        inner(el, indent)
      else
        format_as_block_html(el.type, el.attr, inner(el, indent), indent)
      end
    end
  end
end

module Nanoc::DKramdown
  class Filter < Nanoc::Filter
    identifier :dkramdown
    
    def run(content, params = {})
      Kramdown::Document.new(content, params.merge( {:input => 'DKMramdown'} ) ).to_html
    end 
  end
end
