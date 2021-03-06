describe RunLoop::CoreSimulator do
  let(:simulator) { RunLoop::SimControl.new.simulators.sample }
  let(:app) { RunLoop::App.new(Resources.shared.cal_app_bundle_path) }
  let(:xcrun) { RunLoop::Xcrun.new }

  let(:core_sim) do
    RunLoop::CoreSimulator.new(simulator, app)
  end

  before do
    allow(RunLoop::Environment).to receive(:debug?).and_return true
  end

  after do
    RunLoop::CoreSimulator.terminate_core_simulator_processes
    sleep 2
  end

  describe '#launch_simulator' do
    it 'can launch the simulator' do
      expect(core_sim.launch_simulator).to be_truthy
    end

    it 'it does not relaunch if the simulator is already running' do
      core_sim.launch_simulator

      expect(Process).not_to receive(:spawn)

      core_sim.launch_simulator
    end

    it 'quits the simulator if it is not the same' do

    end
  end

  it '#launch' do
    expect(core_sim.launch).to be_truthy
  end

  it 'install with simctl' do
    args = ['simctl', 'erase', simulator.udid]
    xcrun.exec(args, {:log_cmd => true })

    simulator.simulator_wait_for_stable_state

    expect(core_sim.install)
    expect(core_sim.launch)
  end

  it 'uninstall app and sandbox with simctl' do
    expect(core_sim.uninstall_app_and_sandbox)
    expect(core_sim.app_is_installed?).to be_falsey
  end
end
