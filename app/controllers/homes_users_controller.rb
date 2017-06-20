class HomesUsersController < ApiController
  before_action :set_homes_user, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /homes_users
  def index
    @homes_users = HomesUser.all

    render json: @homes_users
  end

  # GET /homes_users/1
  def show
    render json: @homes_user
  end

  # POST /homes_users
  def create
    @homes_user = HomesUser.new(homes_user_params)

    if @homes_user.save
      render json: @homes_user, status: :created, location: @homes_user
    else
      render json: @homes_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /homes_users/1
  def update
    if @homes_user.update(homes_user_params)
      render json: @homes_user
    else
      render json: @homes_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /homes_users/1
  def destroy
    @homes_user.destroy
  end

  def set_admin
    @user = User.find_by(email: params[:email])
    @homes_user = HomesUser.find_by(home_id: params[:home_id],user_id: @user.id)
    if @homes_user.update(is_admin: true)
       render json: @homes_user
    else
      render json: @homes_user.errors, status: :unprocessable_entity
    end
  end

  def unset_admin
    @user = User.find_by(email: params[:email])
    @homes_user = HomesUser.find_by(home_id: params[:home_id],user_id: @user.id)
    if @homes_user.update(is_admin: false)
       render json: @homes_user
    else
      render json: @homes_user.errors, status: :unprocessable_entity
    end
  end

  def home_member
    @member = User.joins(:homes_users).where('homes_users.home_id':2).select(:email,:image,'homes_users.is_admin')
    render json: @member
  end

  def add_member
    @new_member = User.find_by(email: params[:email])
    if @new_member.nil?
      @new_member = 'User Not Found'
    else
      @new_member = HomesUser.create(home_id: params[:home_id],user_id: @new_member.id)
    end
  render json: @new_member.to_json
  end

  def delete_member
    @delete_member = User.find_by(email: params[:email])
      if @delete_member.nil?
        @delete_member = 'User Not Found'
        render json: false
      else
        @delete_member = HomesUser.delete(home_id: params[:home_id],user_id: @delete_member.id)
        render json: true
      end
  end

  def admin_filter
      @user = HomesUser.find_by(home_id: params[:home_id],user_id: current_user.id)
      if @user.nil?
        @admin_status = false
      elsif @user.is_admin == true
        @admin_status = true
      else @user.is_admin == false
        @admin_status = false
      end
      render json: @admin_status
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homes_user
      @homes_user = HomesUser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def homes_user_params
      params.permit(:user_id, :home_id)
    end
    def admin_params
      params.permit(:is_admin)
    end
end
