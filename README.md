# Pixelpress

Modeled after `ActionMailer`, this gem allows you to render PDFs from HTML via Rails' templating engine. Additionally, you can preview your PDF templates via a supplied Rails engine during development.

## Installation

Add Pixelpress to your application's Gemfile:

```ruby
gem "pixelpress"
```

And then execute:

```bash
$ bundle
```

You'll also need [WeasyPrint](https://weasyprint.org/). It needs to be installed and added to your `PATH`, so that `which weasyprint` returns the location of the binary. Read their installation instructions here: https://doc.courtbouillon.org/weasyprint/stable/first_steps.html#installation

## Usage

Run the printer generator providing the name of your printer with methods to be generated:
```bash
rails generate pixelpress:printer NAME [method_name1 method_name2 ...] [options]
```

This creates the new printer in `app/printers`. If you run it the first time, it will also add an `ApplicationPrinter` and mount the Rails engine in your `config/routes.rb` file.

**Example**

```bash
$ rails g pixelpress:printer invoice customer_invoice delivery_document
```

will generate an `app/printers/invoice_printer.rb` file with this content:

```ruby
class InvoicePrinter < ApplicationPrinter
  def customer_invoice
    # put your code here
  end

  def delivery_document
    # put your code here
  end
end
```

The command will also generate corresponding templates  as `.pdf.erb` files located in `app/views/printers/invoice/`:

- `customer_invoice.pdf.erb`
- `delivery_document.pdf.erb`

You can preview your documents by running `rails s` and go to

```
http://localhost:3000/rails/printers
```

To use your printers in code, you can use them similarly to how you'd use mailers:

```ruby
InvoicePrinter.customer_invoice.pdf # render a temporary pdf file
InvoicePrinter.customer_invoice.html # get the rendered document in html format
```

So you can send them to the client via a controller action:

```ruby
class InvoicesController < ApplicationController
  def show
    document = InvoicePrinter.customer_invoice
    respond_to do |format|
      format.html { render html: document.html }
      format.pdf { send_data document.pdf.read, disposition: 'inline', type: 'application/pdf' }
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Alex/pixelpress.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
