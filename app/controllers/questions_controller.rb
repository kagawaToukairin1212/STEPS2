class QuestionsController < ApplicationController
    before_action :set_question, only: [ :show, :edit, :update, :destroy, :update_status ]
    def index
        @questions = Question.includes(:user)

        case params[:filter]
        when "unresolved"
          @questions = @questions.unresolved
        when "resolved"
          @questions = @questions.resolved
        when "my_questions"
          @questions = @questions.where(user: current_user)
        when "answered"
          @questions = @questions.joins(:question_responses).where(question_responses: { user_id: current_user.id }).distinct
        end
    end

    def show
        @question = Question.find(params[:id])
    end

    def new
        @question = Question.new
    end

    def create
        @question = current_user.questions.build(question_params)
        if @question.save
          redirect_to questions_path, notice: "質問を作成しました。"
        else
          render :new
        end
    end

    def update_status
        @question = Question.find(params[:id])
        if @question.unresolved?
          @question.update(status: :resolved)
          redirect_to @question, notice: "質問を解決済みにしました。"
        else
          @question.update(status: :unresolved)
          redirect_to @question, notice: "質問を未解決に戻しました。"
        end
    end

    def edit
        @question = Question.find(params[:id])
    end

    def update
      if @question.update(question_params)
        redirect_to @question, notice: "質問を更新しました。"
      else
        render :edit
      end
    end

    def destroy
      @question.destroy
      redirect_to questions_path, notice: "質問を削除しました。"
    end

    private

    def set_question
        @question = Question.find_by(id: params[:id])
        unless @question
          redirect_to questions_path, alert: "対象の質問が見つかりません。"
        end
    end

    def question_params
        params.require(:question).permit(:subject, :content)
    end

    def authorize_user
        unless @question.user == current_user
          redirect_to questions_path, alert: "他のユーザーの質問は編集できません。"
        end
    end
end
