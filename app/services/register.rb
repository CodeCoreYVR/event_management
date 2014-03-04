class Register
  attr_accessor :success
  attr_accessor :attendee
  # @attendee=0
  # @success=0
  def initialize (pars={},success=false)
    @attendee = Attendee.find_by_email(pars[:email]) || Attendee.new(pars)
    @success = success
  end
  
  def self.create(pars)
    result= new (pars || nil)
    result.success=result.call(pars[:category_ids] || [],pars[:event_ids] || [])
    result
  end

  def call (cat_ids,ev_ids)
    # ActiveRecord::Base.transaction do
    begin
      @attendee.categories += Category.find(cat_ids.delete_if{|x| x.empty?} )
      @attendee.events     += Event.find(ev_ids)
    rescue
    end
    # p @attendee.inspect
    if ev_ids.present? && @attendee.save
      true
    else
      model_validation_messages
      # redirect_to root_path + '#section-signup', alert: @message+@errs
      false
    end
    # end
  end
    def model_validation_messages
      if @attendee.errors.any?
        @attendee.errors.delete(:attendances)
        @errs = @attendee.errors.full_messages.join(" and ")
        @dependent_errs=''
        @dependent_errs += (@attendee.attendances.map{ |x| x.errors.full_messages.join(" and ") }).join(" and ")
        @errs +=" and " unless @dependent_errs.blank? || @errs.blank?
        @errs += @dependent_errs
      end
      @errs||= ''
    end
end
#   if event_number_check && @attendee.save
#     AttendeeMailer.delay.notify_attendee(@attendee)
#   else
#     @message ||= ''
#     model_validation_messages
#     redirect_to root_path + '#section-signup', alert: @message+@errs
#   end


#   def event_number_check 
#   if pars[:attendee][:event_ids].present?
#     true
#   else
#     @message = "You have to choose some events."
#     false
#   end
# end

# end


