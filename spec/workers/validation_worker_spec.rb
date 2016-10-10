require 'rails_helper'

describe ValidationWorker do
  subject(:job) { described_class.perform_async(game.id, service_name) }

  let(:game) { create :game }
  let(:service_name) { 'Validations::BlacklistValidation' }

  it { expect(described_class).to be_processed_in :validations }
  it { expect(described_class).to be_retryable 3 }

  it 'enqueue a job' do
    expect { job }.to change(described_class.jobs, :size).by(1)
  end

  it 'executes perform' do
    validation_service = double(service_name)
    allow(validation_service).to receive(:validate).and_return(no_args)

    expect(service_name.constantize).to receive(:new).with(game.id) { validation_service }

    Sidekiq::Testing.inline! { job }
  end
end
