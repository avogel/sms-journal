class EntriesController < ApplicationController
    before_action :set_entry, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only: [:index, :show, :edit, :destroy]

    skip_before_filter :verify_authenticity_token, :only => [:process_text]

    def index
        @entries_by_date = current_user.entries_by_date
    end

    # GET /entries/1
    # GET /entries/1.json
    def show
    end

    # GET /entries/1/edit
    def edit
    end

    def process_sms
        message_body = params["Body"]
        from_number = params["From"]
        logger.debug "processing sms"
        logger.debug from_number
        logger.debug message_body
        user = User.find_by(phone_number: from_number)
        if user.entries.any?{|entry| entry.created_at > 10.minutes.ago}
            entry = user.entries.last.body += message_body
        else
            entry = Entry.create(:body => message_body, :user => user, :submit_date => Date.today)
        end
    end

    #send comfirmation text after an entry is successfully made
    def comfirm_text
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_entry
        @entry = Entry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
        params.require(:entry).permit(:body)
    end
end
