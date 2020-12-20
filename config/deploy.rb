# capistranoのバージョンを記載。固定のバージョンを利用し続け、バージョン変更によるトラブルを防止する
lock '3.14.1'

# Capistranoのログの表示に利用する
set :application, 'furima-29074'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:erika618/furima-29074.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user

# このアプリで使用しているrubyのバージョン
set :rbenv_ruby, '2.6.5' 

# どの公開鍵を利用してデプロイするか
set :ssh_options, auth_methods: ['publickey'],
                                  keys: ['~/.ssh/sde234grwwsfcfxgb.pem'] 

# プロセス番号を記載したファイルの場所（sharedには、バージョンが変わっても共通で参照されるlog、public、tmp、vendorディレクトリが格納）
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所（現在デプロイされている内容＝カレント内の内容）
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
# 今回は5つ、過去のバージョンを保存するように設定
set :keep_releases, 5

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end