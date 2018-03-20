# frozen_string_literal: true
class SushiController < ApplicationController

  def index
    @sushi = Sushi.where(user_id: session[:user_id])
  end

  def new
    @sushi = Sushi.new
  end

  def create
    @sushi = Sushi.new(sushi_params)
    if @sushi.save
      redirect_to('/sushi')
    else
      flash[:danger] = "Error: #{@sushi.errors.full_message(@sushi.name, 'already exists')}"
      redirect_to ('/sushi/new')
    end
  end

  def edit
    @sushi = Sushi.find(params[:id])
    unless session[:user_id] == @sushi.user_id
      flash[:danger] = "That's not your sushi connection"
      redirect_to root_path
      return
    end
  end

  def update
    @sushi = Sushi.find(params[:id])
    @sushi.update_attributes(sushi_params)
    if @sushi.save
      redirect_to('/sushi')
    else
      flash[:danger] = "Error: #{@sushi.errors.full_messages}"
      redirect_back(fallback_location: root_path)
    end
  end

  def test
    @sushi = Sushi.find(params[:id])
    @response = helpers.sushi_call
    @error = helpers.error
    unless session[:user_id] == @sushi.user_id
      flash[:danger] = "That's not your sushi connection"
      redirect_to root_path
      return
    end
  end

  def call
    @sushi = Sushi.find(params[:id])
    #Ensure user can only access their own connections
    unless session[:user_id] == @sushi.user_id
      flash[:danger] = "That's not your sushi connection"
      redirect_to root_path
      return
    end
    begin
      #Call this process in a new thread, as it can take a while.
      thread = Thread.new do
        #Not possible to deadlock in this case, but still best practice to wrap new thread code
        Rails.application.executor.wrap do
          helpers.sushi_call
          helpers.months_math(@sushi.report_start, @sushi.report_end)
          helpers.count_months
          helpers.xml_open
          helpers.get_secondary_data
          helpers.get_item_data
          helpers.get_total_data
        end
      end
      #Rejoin the completed thread to deliver content
      thread.join
        respond_to do |format|
          format.html
          format.csv { send_data helpers.data_write("\,"), filename: "#{@sushi.name}-#{Date.today}.csv" }
          format.tsv { send_data helpers.data_write("\t"), filename: "#{@sushi.name}-#{Date.today}.tsv" }
        end
    rescue
      redirect_to("/sushi")
      flash[:danger] = "Failure, try testing your connection"
    end
  end

  def destroy
    @sushi = Sushi.find(params[:id])
    unless session[:user_id] == @sushi.user_id
      flash[:danger] = "That's not your sushi connection"
      redirect_to root_path
      return
    end
    @sushi.destroy
    respond_to do |format|
      format.html { redirect_to('/sushi')}
      format.json { head :no_content }
    end
  end

  def sushi_params
    params.require(:sushi).permit(:name, :endpoint, :cust_id, :req_id, :report_start, :report_end, :password, :organization_id)
  end
end
