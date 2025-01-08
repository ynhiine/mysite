#!/usr/bin/env bash
set -o errexit

# Cài đặt gems và precompile assets
bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean

# Chạy migrate
bundle exec rails db:migrate

# Tạo user đầu tiên nếu chưa tồn tại

bundle exec rails runner "User.create!(email_address: ENV['USER_EMAIL'], password: ENV['USER_PASSWORD'], password_confirmation: ENV['USER_PASSWORD']) unless User.exists?(email_address: ENV['USER_EMAIL'])"
