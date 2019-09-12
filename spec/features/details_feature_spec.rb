feature 'details feature' do
  let(:user) { create :employee }

  before do
    prepare_cut_and_materials
    login_as user

    %w[detailOne detailTwo detailThree].each do |name|
      create(:detail, name: name, status: :expects_assessed, client: create(:client), load_type: :custom, cut_material: CutMaterial.last)
    end
  end

  scenario 'must go to the details page' do
    visit details_path

    expect(Detail.count).to eq(3)
    expect(page).to have_content('detailOne')
    expect(page).to have_content('detailTwo')
    expect(page).to have_content('detailThree')
    expect(page).to have_current_path(details_path)
  end

  context 'tabs navigation' do
    before do
      create(:detail, name: 'assessed', status: :assessed, client: create(:client), load_type: :custom, cut_material: CutMaterial.last)
      create(:detail, name: 'expects', status: :expects_assessed, client: create(:client), load_type: :custom, cut_material: CutMaterial.last)
      create(:detail, name: 'not', status: :not_assessed, client: create(:client), load_type: :custom, cut_material: CutMaterial.last)
      create(:detail, name: 'appraised', status: :appraised, client: create(:client), load_type: :custom, cut_material: CutMaterial.last)
    end

    scenario 'only appraised details' do
      visit details_path

      find_link('Оцененные').click
      expect(page).to have_content('appraised')

      expect(page).not_to have_content('assessed')
      expect(page).not_to have_content('expects')
      expect(page).not_to have_content('not')
    end

    scenario 'only not assessed details' do
      visit details_path

      find_link('Невозможно оценить').click
      expect(page).to have_content('not')

      expect(page).not_to have_content('expects')
      expect(page).not_to have_content('appraised')
      expect(page).not_to have_content('assessed')
    end

    scenario 'only expects assessed details' do
      visit details_path

      find_link('Новые').click
      expect(page).to have_content('expects')

      expect(page).not_to have_content('assessed')
      expect(page).not_to have_content('not')
      expect(page).not_to have_content('appraised')
    end

    scenario 'only assessed details' do
      visit details_path

      find_link('Оцениваются').click
      expect(page).to have_content('assessed')

      expect(page).not_to have_content('expects')
      expect(page).not_to have_content('not')
      expect(page).not_to have_content('appraised')
    end
  end
end
