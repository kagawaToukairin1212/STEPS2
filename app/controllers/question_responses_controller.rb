class QuestionResponsesController < ApplicationController
    before_action :require_login
    before_action :set_response, only: [ :edit, :update, :destroy ]
    before_action :authorize_user, only: [ :edit, :update, :destroy ]
    def create
        @question = Question.find(params[:question_id])
        @response = @question.question_responses.build(response_params)
        @response.user = current_user

        if @response.save
          redirect_to question_path(@question), notice: "返答を投稿しました。"
        else
          flash[:alert] = "返答の投稿に失敗しました。"
          render "questions/show"
        end
    end

    def edit
    end

    def update
      if @response.update(response_params)
        redirect_to question_path(@response.question), notice: "返答を更新しました。"
      else
        render :edit
      end
    end

    def destroy
      @response.destroy
      redirect_to question_path(@response.question), notice: "返答を削除しました。"
    end

    private

    def set_response
        @response = QuestionResponse.find(params[:id])
    end

    def response_params
        params.require(:question_response).permit(:subject, :content)
    end

    def authorize_user
        unless @response.user == current_user
          redirect_to question_path(@response.question), alert: "他のユーザーの返答は編集できません。"
        end
    end
end
