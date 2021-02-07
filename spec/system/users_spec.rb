require 'rails_helper'

def basic_pass
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}"
end

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができるとき' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # basic_passのメソッドを実行
      basic_pass
      # トップページに移動する
      root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.last_name
      fill_in 'first-name', with: @user.first_name
      fill_in 'last-name-kana', with: @user.last_name_kana
      fill_in 'first-name-kana', with: @user.first_name_kana
      select '1930', from: 'user_birthday_1i'
      select '1', from: 'user_birthday_2i'
      select '17', from: 'user_birthday_3i'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect do
        find('input[name="commit"]').click
      end.to change { User.count }.by(1)
      # トップページへ遷移する
      expect(current_path).to eq root_path
      # カーソルを合わせるとログアウトボタンが表示されることを確認する
      expect(
        find('.logout').hover
      ).to have_content('ログアウト')
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '空の情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name-kana', with: ''
      fill_in 'first-name-kana', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq '/users'
    end
    it '（バリデーションで制約をかけているため）制約外の情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'email', with: '＠なし'
      fill_in 'password', with: '漢字'
      fill_in 'password-confirmation', with: '漢字'
      fill_in 'last-name', with: 'hankaku'
      fill_in 'first-name', with: 'hankaku'
      fill_in 'last-name-kana', with: 'ひらがな'
      fill_in 'first-name-kana', with: 'ひらがな'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect  do
        find('input[name="commit"]').click
      end.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq '/users/sign_up'
    end
  end
end
