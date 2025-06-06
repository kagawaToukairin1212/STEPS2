require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :system do
  # it '正しいタイトルが表示されていること' do
  # visit '/users/new'
  # expect(page).to have_title("ユーザー登録 | RUNTEQ BOARD APP"), 'ユーザー登録ページのタイトルに「ユーザー登録 | RUNTEQ BOARD APP」が含まれていません。'
  # end

  context '入力情報正常系' do
    it 'ユーザーが新規作成できること' do
      visit '/users/new'
      expect {
        fill_in 'お名前', with: 'らんてっく たろう'
        fill_in 'メールアドレス', with: 'example@example.com'
        fill_in 'パスワード', with: '12345678'
        fill_in 'パスワード（確認用）', with: '12345678'
        click_button '登録'
        Capybara.assert_current_path("/", ignore_query: true)
      }.to change { User.count }.by(1)
      expect(page).to have_content('ユーザー登録が完了しました'), 'フラッシュメッセージ「ユーザー登録が完了しました」が表示されていません'
    end
  end

  context '入力情報異常系' do
    it 'ユーザーが新規作成できない' do
      visit '/users/new'
      expect {
        fill_in 'メールアドレス', with: 'example@example.com'
        click_button '登録'
      }.to change { User.count }.by(0)
      expect(page).to have_content('ユーザー登録に失敗しました'), 'フラッシュメッセージ「ユーザー登録に失敗しました」が表示されていません'
    end
  end
end
