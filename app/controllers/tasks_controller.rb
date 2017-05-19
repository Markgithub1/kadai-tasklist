class TasksController < ApplicationController
  def index
    @tasks = Task.all.page(params[:page]).per(5)
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'Taskが正常に追加されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Taskの追加ができませんでした'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update (task_params)
      flash[:success] = 'Taskは正常に更新されました'
      redirect_to root_path
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to current_user
  end

  private
  def task_params
    params.require(:task).permit(:content, :status, :id)
  end
end
