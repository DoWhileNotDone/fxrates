class CreateFeedTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :feed_types do |t|

      t.timestamps
      t.text :source
      t.text :feed_type
      t.text :uri
      t.text :fetcher_type
      t.text :parser_type
    end
  end
end
