class EntriesController < ApplicationController
    before_action :set_entry, only: [:show, :edit, :update, :destroy]
    before_action :require_login, only: [:index, :show, :edit, :destroy]
    # GET /entries
    # GET /entries.json
    def index
        @entries = current_user.entries.all
    end

    def process_text
        message_body = params["Body"]
        from_number = params["From"]
        logger.debug "LOGGGGGGGGIIIIIINNNNNNNNGGGGGGG"
        logger.debug from_number
        logger.debug message_body
        user = User.find_by(phone_number: from_number)
        entry = Entry.new()
        logger.debug user.phone_number
        entry.body = message_body
        entry.user = user
        entry.save()
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
