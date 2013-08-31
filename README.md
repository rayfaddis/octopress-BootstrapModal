Boostrap Image Modal for Octopress
========================
For the Octopress blogging engine.

Uses Twitter Bootstrap Modal windows for displaying larger images in a popup dialog. Allows for scaled down clickable thumbnails with the use of Mini Magick to calculate the appropriate size with a given percentage.
 
This plugin is useful when you want to display an image as a thumbnail, with the option to display it in it's full size with a popup. Alternatively you may just have an image that's too wide for the blog.

## Prerequisites
1. The "mini_magick" and "erubis" gems
2. [ImageMagick][] toolkit, you will need the mogrify function in your PATH variable, if not already

	For more information on the Image Magick toolkit you may visit http://www.imagemagick.org/.
	
	For installing on OS X I recommend using [MacPorts][] just as ImageMagick recommends, for more information on MacPorts, http://www.macports.org/.

3. [jQuery][] plugin

	I recommend the hosted version https://developers.google.com/speed/libraries/devguide#jquery.

4. [Twitter Boostrap][]

	This example uses Boostrap 3.0 provided by http://www.bootstrapcdn.com/.

Note: For me I also needed to update my Perl version as implemting this broke the Octopress build. I went from version 5.10 to 5.16. See http://learn.perl.org/installing/ for upgrading your Perl version.

## Installation
1. Gemfile

  Update your `Gemfile` by adding these lines:

        gem 'mini_magick'
        gem 'erubis'

	Don't forget to run a `bundle install` to install the gems

2. JS and CSS

	Add these lines to your `sources/_includes/custom/head.html` file:

        <!--Twitter Boostrap-->
        <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet">
        <script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>

3. Copy the plugin

  Finally, copy `img_popup.rb` and `img_popup.html.erb` to your `plugins` directory.

## Usage and Examples
The plugin implements a [Liquid][] template tag which can be used in blog posts as shown:
   
    {% imgpopup /path/to/image percent% [float alignment (left|right)] [title] %}

  1. The image path is relative to the source directory.
  2. The percent argument is the amount to scale the image down for the clickable thumbnail preview.
  3. The optional float\alignment will align your image and wrap text around it (see [w3schools][]).
  4. The optional title will be the title\tooltip text when hovering over the image and will also be put in the title bar of the modal popup.

Examples:

    {% imgpopup /images/bigimage.png 50% right My Big Image %} <!--Loaded and fully dressed-->
    {% imgpopup /images/bigimage.png 50% My Big Image %} <!--No alignment, with a title-->
    {% imgpopup /images/bigimage.png 50% right %} <!--Alignment with no title-->
    {% imgpopup /images/bigimage.png 50% %} <!--Bare, no alignment or title-->
    
For a live example visit http://www.rayfaddis.com/blog/2013/05/27/jquery-validation-with-twitter-bootstrap/

## License
This plugin is licensed under the [BSD 3-Clause License][bsd-license]

[blog-image-popup]: http://brizzled.clapper.org/blog/2012/02/05/a-simple-octopress-image-popup-plugin/
[Octopress]: http://octopress.org/
[ImageMagick]: http://www.imagemagick.org/
[MacPorts]: http://www.macports.org/
[jQuery]: http://jquery.com/
[Twitter Boostrap]: http://getbootstrap.com
[Liquid]: https://github.com/Shopify/liquid
[w3schools]: http://www.w3schools.com/cssref/pr_class_float.asp
[bsd-license]: http://opensource.org/licenses/BSD-3-Clause
