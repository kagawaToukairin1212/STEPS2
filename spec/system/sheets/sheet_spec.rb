require 'rails_helper'

RSpec.describe 'シート作成', type: :system do
  let(:user) { create(:user) }

  describe 'シート作成' do
    before do
      EvaluationDepartment.create!([
          { name: 'リズム能力', default: true },
          { name: 'バランス能力', default: true },
          { name: '変換能力', default: true },
          { name: '反応能力', default: true },
          { name: '連結能力', default: true },
          { name: '定位能力', default: true },
          { name: '識別能力', default: true }
      ])

        login_as(user)
    end

    context '正常な入力' do
      it 'シートが作成できる' do
        click_link 'シートを追加する'
        fill_in 'シートタイトル', with: '新しいシート'
        fill_in 'リズム能力', with: 'リズムを強化する'
        fill_in 'バランス能力', with: 'バランスを整える'
        fill_in '変換能力', with: '変換能力を強化する'
        fill_in '反応能力', with: '反応能力を強化する'
        fill_in '連結能力', with: '連結能力を整える'
        fill_in '定位能力', with: '定位能力を強化する'
        fill_in '識別能力', with: '識別能力を整える'
        click_button '保存する'

        expect(page).to have_content I18n.t('sheet.new.success')
        expect(current_path).to eq mypage_path
      end
    end

    context 'タイトルが空の場合' do
      it '作成に失敗する' do
        click_link 'シートを追加する'
        fill_in 'シートタイトル', with: ''
        fill_in 'リズム能力', with: 'リズムを強化する'
        fill_in 'バランス能力', with: 'バランスを整える'
        fill_in '変換能力', with: '変換能力を強化する'
        fill_in '反応能力', with: '反応能力を強化する'
        fill_in '連結能力', with: '連結能力を整える'
        fill_in '定位能力', with: '定位能力を強化する'
        fill_in '識別能力', with: '識別能力を整える'

        click_button '保存する'

        expect(page).to have_selector('input:invalid')
      end
    end

    context '目標が空の場合' do
      it '作成に失敗する' do
        click_link 'シートを追加する'
        fill_in 'シートタイトル', with: '新しいシート'
        fill_in 'リズム能力', with: ''
        fill_in 'バランス能力', with: 'バランスを整える'
        fill_in '変換能力', with: '変換能力を強化する'
        fill_in '反応能力', with: '反応能力を強化する'
        fill_in '連結能力', with: '連結能力を整える'
        fill_in '定位能力', with: '定位能力を強化する'
        fill_in '識別能力', with: '識別能力を整える'

        click_button '保存する'

        expect(page).to have_selector('textarea:invalid')
      end
    end
  end
end
