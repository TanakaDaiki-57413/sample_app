class ListsController < ApplicationController


  def new
    @list = List.new
  end

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def edit
    @list =List.find(params[:id])
  end

  #新規作成
  def create
    @list = List.new(list_params)
    if @list.save  #データ入力チェック
      flash[:notice] = "投稿に成功しました"
      redirect_to list_path(@list.id)
    else #エラー処理
      flash.now[:alert] = "投稿に失敗しました"
      render :new, status: :unprocessable_entity #新規投稿ページ再表示
      # エラー詳細内容は表示しない場合の書きかた
      # redirect_to new_list_path
    end
  end


  #更新処理
  def update
    list = List.find(params[:id])
    list.update(list_params)
    redirect_to list_path(list.id)
  end

  #削除処理
  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to "/lists"
  end
  private
  # ストロングパラメータ
  def list_params
    params.require(:list).permit(:title, :body, :"image")
  end
end
