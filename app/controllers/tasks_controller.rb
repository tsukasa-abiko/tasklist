class TasksController < ApplicationController
  def index
    @tasks = Task.all  
  end
  
  def show
    @task = Task.find(params[:id]) 
  end
  
  def new
    @task = Task.new  
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      # flash → 一瞬という意味
      # リダイレクト先でのみ使われるメッセージのことを、flashメッセージという。
      flash[:success] = 'Task が正常に投稿されました'
      # TasksControllerのshowアクションへのリンク
      # 下記はどちらも同じ
      # redirect_to @task
      redirect_to task_path(@task)
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :new
    end
  end
  
  def edit
    # 投稿ボタンを押すと、TasksControllerのupdateアクションにとぶ
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end

  private
  
  def task_params
    # Strong Parameter
    # 新規作成、編集するカラムが増えた際にはここに必ず追記する
    params.require(:task).permit(:content, :status)
  end
end
