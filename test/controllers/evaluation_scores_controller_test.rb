require "test_helper"

class EvaluationScoresControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get evaluation_scores_new_url
    assert_response :success
  end

  test "should get create" do
    get evaluation_scores_create_url
    assert_response :success
  end
end
