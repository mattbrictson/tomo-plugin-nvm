require "test_helper"

class Tomo::Plugin::Nvm::TasksTest < Minitest::Test
  def test_install_modifies_bashrc
    bashrc = <<~SH
      # example bashrc
    SH
    tester = configure(nvm_node_version: "10.15.3")
    tester.mock_script_result("cat .bashrc", stdout: bashrc)
    tester.run_task("nvm:install")

    assert_equal(<<~'CMD'.strip, tester.executed_scripts[2])
      echo -n export\ NVM_DIR\=\"\$HOME/.nvm\"'
      '\[\ -s\ \"\$NVM_DIR/nvm.sh\"\ \]\ \&\&\ \\.\ \"\$NVM_DIR/nvm.sh\"'
      ''
      '\#\ example\ bashrc'
      ' > .bashrc
    CMD
  end

  def test_install_does_not_modify_bashrc_if_already_modified
    bashrc = <<~'SH'
      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && \\. "$NVM_DIR/nvm.sh"
    SH
    tester = configure(nvm_node_version: "10.15.3")
    tester.mock_script_result("cat .bashrc", stdout: bashrc)
    tester.run_task("nvm:install")

    assert_empty tester.executed_scripts.grep(/echo/)
  end

  def test_install_uses_nvm_to_install_specified_version_of_node
    tester = configure(nvm_node_version: "10.15.3")
    tester.run_task("nvm:install")
    refute_empty tester.executed_scripts.grep("nvm install 10.15.3")
  end

  def test_install_skips_node_if_already_installed
    tester = configure(nvm_node_version: "10.15.3")
    tester.mock_script_result("nvm ls", stdout: <<~OUT)
      ->     v10.15.3
    OUT
    tester.run_task("nvm:install")
    assert_empty tester.executed_scripts.grep(/nvm install/)
  end

  def test_install_makes_the_specified_node_version_active
    tester = configure(nvm_node_version: "10.15.3")
    tester.run_task("nvm:install")
    refute_empty tester.executed_scripts.grep("nvm alias default 10.15.3")
  end

  def test_install_uses_npm_to_install_specified_version_of_yarn
    tester = configure(
      nvm_node_version: "10.15.3",
      nvm_yarn_version: "1.17.3"
    )
    tester.run_task("nvm:install")
    refute_empty tester.executed_scripts.grep("npm i -g yarn@1.17.3")
  end

  def test_install_skips_yarn_if_no_yarn_version_specified
    tester = configure(nvm_node_version: "10.15.3")
    tester.run_task("nvm:install")
    assert_empty tester.executed_scripts.grep(/yarn/)
  end

  def test_install_raises_if_nvm_node_version_is_not_specified
    tester = configure
    assert_raises(Tomo::Runtime::SettingsRequiredError) do
      tester.run_task("nvm:install")
    end
  end

  private

  def configure(settings={})
    Tomo::Testing::MockPluginTester.new("nvm", settings:)
  end
end
