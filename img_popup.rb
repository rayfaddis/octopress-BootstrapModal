########################################################################################################################
# ABOUT
########################################################################################################################
#
# Author: Ray Faddis
# Updated: 8/31/2013
#
# Uses Twitter Bootstrap Modal windows for displaying larger images in a popup dialog. Allows for scaled down thumbnails
# with the use of Mini Magick to calculate the appropriate size with a given percentage.
# 
# This plugin is useful when you want to display an image as a thumbnail, with the option to display it in it's full 
# size with a popup. Alternatively you may just have an image that's too wide for the blog.
#
########################################################################################################################
# INSTRUCTIONS
########################################################################################################################
#
# Please see https://github.com/rayfaddis/octopress-BootstrapModal for the full source, prereqeusites, installation, 
# usage, and examples.
#
########################################################################################################################
# CREDITS
########################################################################################################################
#
# This project is a fork from Brian M. Clapper's project at https://github.com/rayfaddis/octopress-plugins and thus is
# almost identical.
#
# Copyright (c) 2013 Ray Faddis <ray.faddis@gmail.com>
# Released under the BSD (3-clause) license: http://opensource.org/licenses/BSD-3-Clause
#
########################################################################################################################

require 'mini_magick'
require 'rubygems'
require 'erubis'
require './plugins/raw'

module Jekyll

  class ImgPopup < Liquid::Tag
    include TemplateWrapper

    @@id = 0

    TEMPLATE_NAME = 'img_popup.html.erb'

    def initialize(tag_name, markup, tokens)
      args = markup.strip.split(/\s+/, 4)
      raise "Usage: imgpopup path nn% [float] [title]" unless [3, 4].include? args.length

      @path = args[0]
      if args[1] =~ /^(\d+)%$/
        @percent = $1
      else
        raise "Percent #{args[1]} is not of the form 'nn%'"
      end

      template_file = Pathname.new(__FILE__).dirname + TEMPLATE_NAME
      @template = Erubis::Eruby.new(File.open(template_file).read)

      if args[2] == "left" || args[2] == "right"
        @float = args[2].titlecase
        @title = args[3]
      else
        @title = args[2] + ' ' + args[3]
      end

      super
    end

    def render(context)
      source = Pathname.new(context.registers[:site].source).expand_path

      # Calculate the full path to the source image.
      image_path = source + @path.sub(%r{^/}, '')

      @@id += 1
      vars = {
        'id'      => @@id.to_s,
        'image'   => @path,
        'title'   => @title,
        'float'   => @float,
        'margin'  => @margin
      } 

      # Open the source image, and scale it accordingly.
      image = MiniMagick::Image.open(image_path)
      vars['full_width'] = image[:width]
      vars['full_height'] = image[:height]
      image.resize "#{@percent}%"
      vars['scaled_width'] = image[:width]
      vars['scaled_height'] = image[:height]

      safe_wrap(@template.result(vars))
    end
  end
end

Liquid::Template.register_tag('imgpopup', Jekyll::ImgPopup)