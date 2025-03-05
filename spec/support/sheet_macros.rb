module SheetMacros
    def sheet_create_as(user)
        fill_in 'シートタイトル', with: '新しいシート'
        fill_in 'リズム能力', with: 'リズムを強化する'
        fill_in 'バランス能力', with: 'バランスを整える'
        fill_in '変換能力', with: '変換能力を強化する'
        fill_in '反応能力', with: '反応能力を強化する'
        fill_in '連結能力', with: '連結能力を整える'
        fill_in '定位能力', with: '定位能力を強化する'
        fill_in '識別能力', with: '識別能力を整える'
    end
end
