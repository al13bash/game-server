require 'rails_helper'

describe ValidationWorker do
  subject(:job) { described_class.perform_async }

  it { expect(described_class).to be_processed_in :validations }
  it { expect(described_class).to be_retryable 3 }

  it 'enqueue a job' do
    expect { job }.to change(described_class.jobs, :size).by(1)
  end
end
