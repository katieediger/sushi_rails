class SushiController < ApplicationController
  def index
    @sushi = Sushi.where(user_id: session[:user_id])
  end

  def new
    @sushi = Sushi.new
  end

  def create
    @sushi = Sushi.new(sushi_params)
    @sushi.save
    if @sushi.save
      redirect_to('/sushi')
    else
      flash[:warning] = "Error: #{@sushi.errors.full_messages}"
      redirect_to ('/sushi/new')
    end
  end

  def edit
    @sushi = Sushi.find(params[:id])
  end

  def update
    @sushi = Sushi.find(params[:id])
    @sushi.update_attributes(sushi_params)
    if @sushi.save
      redirect_to('/sushi')
    else
      flash[:warning] = "Error: #{@sushi.errors.full_messages}"
      redirect_back(fallback_location: root_path)
    end
  end

  def test
    @sushi = Sushi.find(params[:id])
    @response = helpers.sushi_call
  end

  def call
    @sushi = Sushi.find(params[:id])
    begin
      helpers.sushi_call
      helpers.months_math(@sushi.report_start, @sushi.report_end)
      helpers.count_months
      respond_to do |format|
        format.html
        format.csv { send_data helpers.csv_open, filename: "#{@sushi.name}-#{Date.today}.csv" }
      end
    rescue
      redirect_to('/sushi')
      flash[:warning] = "Failure, try testing your connection"
    end
  end

  def destroy
    @sushi = Sushi.find(params[:id])
    @sushi.destroy
    respond_to do |format|
      format.html { redirect_to('/sushi')}
      format.json { head :no_content }
    end
  end

  def sushi_params
    params.require(:sushi).permit(:name, :endpoint, :cust_id, :req_id, :report_start, :report_end, :password, :user_id)
  end
end
