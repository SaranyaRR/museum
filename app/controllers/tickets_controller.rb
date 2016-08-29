class TicketsController < ApplicationController
  def list
  	@tickets = Ticket.all
  end

  def search
  	@tickets = nil
  	if params["search_date_time"]
  		@tickets = Ticket.select{|ticket| params["search_date_time"].to_datetime.change(:offset =>Time.now.strftime("%:z")).between?(ticket.in_time, ticket.out_time || Time.now)}
  	end
  end

  def import
  	begin
      @message = nil
  	  tickets_count, errors = Ticket.import(params[:file])
  	  if errors.empty?
        @tickets = Ticket.all
	      @message = "#{tickets_count} tickets were successfully imported."
  		else
        @tickets = Ticket.all
			  @message = "#{tickets_count} tickets were imported. One or more tickets were not imported. Error message : " + "#{errors}"
  		end
    rescue
      redirect_to root_url, notice: "Import failed. Invalid file or the contents could not be parsed. Please verify and reupload again."
    end
  end
end
