class BoardsController < ApplicationController

  before_action :set_board

  def index
    @board = current_user.boards
  end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.new(board_params)

    if @board.save
      redirect_to boards_path, notice: 'create successfully!'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @board.update(board_params)

    if @board.save
      redirect_to boards_path, notice: 'update successfully!'
    else
      render :new
    end
  end

  def destroy
    @board.destroy
    redirect_to boards_path, notice: 'deleted!'
  end



  private
  def set_board
    @board = current_user.boards.find_by(id: params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :description, :language)
  end

end