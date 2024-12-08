require "csv" # CSVファイルを扱うためのライブラリを読み込んでいます

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"
memo_type = gets.to_i # ユーザーの入力値を取得し、数字へ変換しています

if memo_type == 1
  # 新規メモ作成
  puts "新しいメモを作成します。ファイル名を入力してください（拡張子不要）:"
  #chompで入力された文字列の末尾の改行を削除
  file_name = gets.chomp + ".csv"

  puts "メモしたい内容を入力してください。完了したらCtrl+Dを押してください。"
  #readlinesで複数行の入力を配列として取得
  memo_content = readlines.map(&:chomp)

  # CSVファイルに新規作成
  # CSV,openはRubyの標準ライブラリCSVを使ってCSVファイルを操作するメソッド
  # "w"はファイルモードを指定している。書き込み専用モード 既存の内容を上書きする
  # ファイルモードの例  "w"(write) "a"(append)追記専用モード "r"読み取り専用モード
  CSV.open(file_name, "w") do |csv|
    # ユーザーが入力したメモ内容を保持した配列memo_contentをeachを使って配列内の各要素を順に処理する
    memo_content.each do |line|
      # CSVファイルに1行分のデータを追加する
      # [line]の形にするころで配列形式として記録する
      csv << [line]
    end
  end

  puts "メモを保存しました。"

elsif memo_type == 2
  # 既存メモ編集
  puts "編集するメモのファイル名を入力してください（拡張子不要）:"
  file_name = gets.chomp + ".csv"

  # File.exist?メソッドで指定されたファイルが存在するか確認
  if File.exist?(file_name)
    puts "現在のメモの内容:"
    # 存在する場合、CSV.readで内容を配列として読み込み、join("\n")で改行をつけて表示
    puts CSV.read(file_name).join("\n")

    puts "追記したい内容を入力してください。完了したらCtrl+Dを押してください。"
    memo_content = readlines.map(&:chomp)

    # CSVファイルに追記
    CSV.open(file_name, "a") do |csv|
      memo_content.each do |line|
        csv << [line]
      end
    end

    puts "メモを更新しました。"
  else
    puts "指定されたファイルは存在しません。"
  end

else
  puts "1または2を選択してください。"
end
