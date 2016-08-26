class Ticket < ActiveRecord::Base
  require 'csv'

  validates_presence_of :ticket_id
  validates_uniqueness_of :ticket_id
#  validates_inclusion_of :event_type, :in => [ "entry", "exit" ], :message => "has to be entry or exit"

  def self.import(file)
  	errors = []
  	tickets_count = 0
    CSV.foreach(file.path, headers: true) do |row|
      ticket_hash = parse_params(row.to_hash)
      ticket = Ticket.find_or_initialize_by(ticket_id: ticket_hash["ticket_id"])
      if ticket.update(ticket_hash)
      	tickets_count+=1
      else
      	errors << ticket.errors.full_messages
      end
    end # end CSV.foreach
    return [tickets_count, errors.join(',')]
  end # end self.import(file)

  def self.parse_params(row)
  	ticket_hash = {"ticket_id" => row["ticket_id"]}
  	if row["event_type"] == "entry"
  	  ticket_hash["entry"] = true 
  	  ticket_hash["in_time"] = row["timestamp"]
  	elsif row["event_type"] == "exit"
	    ticket_hash["exit"] = true 
  	  ticket_hash["out_time"] = row["timestamp"]
  	end
  	return ticket_hash
  end
end # end class
