class TicketsController < ApplicationController
  def list
  	@tickets = Ticket.all
  end

  def search
  	@count = 0
  	if params["search_date_time"]
  		@count = Ticket.select{|ticket| params["search_date_time"].to_datetime.change(:offset =>Time.now.strftime("%:z")).between?(ticket.in_time, ticket.out_time || Time.now)}.count
  	end
  	redirect_to root_url, notice: "#{@count} people were present in the museum in the given time."
  end

  def import
  	begin
  	  tickets_count, errors = Ticket.import(params[:file])
  	  if errors.empty?
	      redirect_to root_url, notice: "#{tickets_count} tickets were successfully imported."
  		else
			  redirect_to root_url, notice: "#{tickets_count} tickets were imported. One or more tickets were not imported. Error message : " + "#{errors}"
  		end
    rescue
      redirect_to root_url, notice: "Import failed. Invalid file or the contents could not be parsed. Please verify and reupload again."
    end
  end
end
