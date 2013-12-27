class EntriesController < ApplicationController
    before_action :set_entry, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only: [:index, :show, :edit, :destroy]

    skip_before_filter :verify_authenticity_token, :only => [:process_text]
    # GET /entries
    # GET /entries.json
    def index
        @entries_by_date = current_user.entries_by_date
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

    # GET /entries/1
    # GET /entries/1.json
    def show
    end

    # GET /entries/new
    def new
        @entry = Entry.new
    end

    # GET /entries/1/edit
    def edit
    end

    # POST /entries
    # POST /entries.json
    def create
        @entry = Entry.new(entry_params)
        @entry.user = current_user

        if @entry.save
            redirect_to root_url
            flash["notice"] = "New Entry was created successfully"
        else
            render 'new'
        end
  end

  # PATCH/PUT /entries/1
  # PATCH/PUT /entries/1.json
    def update
        respond_to do |format|
            if @entry.update(entry_params)
                format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: 'edit' }
                format.json { render json: @entry.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /entries/1
    # DELETE /entries/1.json
    def destroy
        @entry.destroy
        respond_to do |format|
            format.html { redirect_to entries_url }
            format.json { head :no_content }
        end
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
