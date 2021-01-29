class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat, counter_cache: :messages_count
  
  validates_presence_of :content

  settings analysis: {
    filter: {
      edge_ngram_filter: {
        type: "edgeNGram",
        min_gram: "1",
        max_gram: "50",
      }
    },
    analyzer: {
      edge_ngram_analyzer: {
        type: "custom",
        tokenizer: "standard",
        filter: ["lowercase", "edge_ngram_filter"]
      }
    }
  } do
    mappings do
      indexes :content, type: "text", analyzer: "edge_ngram_analyzer"
    end
  end

  def self.search(query = nil)  
    __elasticsearch__.search(query).records.records
  end
end
