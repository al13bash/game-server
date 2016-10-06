require 'rails_helper'

describe GameWorker do
  subject(:job) { described_class.perform_async(game.id) }

  let(:game) { create :game }

  it { expect(described_class).to be_processed_in :games }
  it { expect(described_class).to be_retryable 3 }

  it 'enqueue a job' do
    expect { job }.to change(described_class.jobs, :size).by(1)
  end

  it 'executes perform' do
    service = double('Games::PlayService')
    allow(service).to receive(:perform).and_return(no_args)

    expect(Games::PlayService).to receive(:new).with(game_id: game.id) { service }

    Sidekiq::Testing.inline! { job }
  end
end
