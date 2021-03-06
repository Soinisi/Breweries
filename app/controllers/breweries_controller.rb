class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :ensure_that_admin, only: [:destroy]
  before_action :skip_if_cached, only:[:index]
  
  #before_action :authenticate, only: [:destroy]


  # GET /breweries
  # GET /breweries.json
  def index
    @breweries = Brewery.all
    @active_breweries = Brewery.active
    @retired_breweries = Brewery.retired
    
    order = params[:order] || 'name'
    
    
    
    ordering(@active_breweries, @retired_breweries, order)
    #@retired_breweries = ordering(@retired_breweries, order)


  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)

    new_status = brewery.active? ? "active" : "retired"

    redirect_to :back, notice:"brewery activity status changed to #{new_status}"
  end


  # POST /breweries
  # POST /breweries.json
  def create
    expire_fragment('brewerylist')
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render :show, status: :created, location: @brewery }
      else
        format.html { render :new }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    expire_fragment('brewerylist')
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { render :show, status: :ok, location: @brewery }
      else
        format.html { render :edit }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    expire_fragment('brewerylist')
    @brewery.destroy
    respond_to do |format|
      format.html { redirect_to breweries_url, notice: 'Brewery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)

    new_status = brewery.active? ? "active" : "retired"

    redirect_to :back, notice:"brewery activity status changed to #{new_status}"
  end

  def list
  end

  def skip_if_cached
    return render :index if fragment_exist?( 'brewerylist' )
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    
    #def authenticate
     # admin_accounts = { "admin" => "secret", "pekka" => "beer", "arto" => "foobar", "matti" => "ittam"}
      #authenticate_or_request_with_http_basic do |username, password|
       # admin_accounts[username] == password
     # end
    #end
    def ordering(data, data2, order)
        


      if order == 'name' and session[:name] == nil
        session[:name] = true
        @active_breweries = data.sort_by{ |b| b.name }
        @retired_breweries = data2.sort_by{ |b| b.name }  
        return  
      
      elsif order == 'name' and session[:name]
        session[:name] = nil
        @active_breweries = data.sort_by{ |b| b.name }.reverse
        @retired_breweries = data2.sort_by{ |b| b.name }.reverse
        return

      elsif order == 'year' and session[:year] == nil
        session[:year] = true
        @active_breweries = data.sort_by{ |b| b.year }
        @retired_breweries = data2.sort_by{ |b| b.year }
        return

      elsif order == 'year' and session[:year]  
        session[:year] = nil
        @active_breweries = data.sort_by{ |b| b.year }.reverse
        @retired_breweries = data2.sort_by{ |b| b.year }.reverse
        return
      end
      
    end

    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end
end
