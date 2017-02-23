# Pixelpress
[![CircleCI](https://circleci.com/gh/nerdgeschoss/pixelpress/tree/master.svg?style=svg)](https://circleci.com/gh/nerdgeschoss/pixelpress/tree/master)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/pixelpress`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pixelpress'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pixelpress

## Usage

Usage instructions: 
	1. run basic generator to get your AppPrinter:
		 $ rails g pixelpress:install   
	2. run printer generator providing name of your printer with methods to be generated:
		 $ rails generate pixelpress:printer NAME [method_name1 method_name2 ...] [options]	 

1.command will run gen that will create folder printers withiun your `app/` and will generate for you generic AppPrinter
2.command will generate custom printer with name and methods that you provided in commandline within folder `app/printers` -> example 
	 $ rails g pixelpress:printer invoice customer_invoice bla_invoice 	
	 it will generate `app/printers/invoice_printer.rb` file that looks like this
  	 ```ruby
  	 class InvoicePrinter < ApplicationPrinter

  	 	def customer_invoice
  	 		#put your code here
  	 	end

  	 	def bla_invoice
  	 		#put here code
  	 	end
  	 end
  	 ```

   Also this command will generate corresponding templates for custom printer, so you will have set of `.pdf.erb` files located in your `app/views/printers/invoice/` folder with this files in it: 
     `customer_invoice.pdf.erb`
     `bla_invoice.pdf.erb`


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Alex/pixelpress.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

