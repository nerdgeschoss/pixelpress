class Pixelpress::PrintersController < ActionController::Base
  def index
    @printers = Pixelpress::Preview.all
  end

  def show
    klass = params[:printer_id]
    method = params[:id]
    printer = Pixelpress::Preview.all.map { |e| [e.printer_name, e] }.to_h[klass].send(method)
    respond_to do |format|
      format.html { render html: printer.html }
      format.pdf { send_data printer.pdf.read, disposition: 'inline', type: 'application/pdf' }
    end
  end
end
