# Changelog

##2014-11-25
### Added
- Added validation for voting (has to be Realistic, Unrealistic or
  Abstain)
- Added "Please select" to voting, to ensure a valid Vote is selected
- Added first integration test

### Changed
- Refasctored IdeasController, move methods to Model
- Tests for Idea Model and Controller
- Added traits for Idea factory for easier testing and reusing
### Removed
nothing

## 2014-11-18
### Added
- This Changelog
- Tests for Idea model
- First feature spec
- Codeship integration
- New test to make sure completed projects do not appear in the archive
- a spec helper

### Changed
- Idea index archive does not include completed projects
- Tests for Idea controller

### Removed
- Old tests that are unnecessary
