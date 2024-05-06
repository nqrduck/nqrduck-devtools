# NQRduck Devtools

This repository contains various scripts and information that is used to develop and maintain the NQRduck project.
I'm primarily using this repository to organize my thoughts.

## Scripts
- init.sh - Initializes the NQRduck project for development by cloning all the repositories. Then it installs the modules in editable mode.
- pull_all.sh - Pulls all the repositories in the NQRduck project.

## Style
- Linting via ruff - following lines are added to the pyproject.toml file
```toml
[tool.ruff]
exclude = [
  "widget.py",
  "base_spectrometer_widget.py",
]

[tool.ruff.lint]
extend-select = [
  "UP",  # pyupgrade
  "D",   # pydocstyle
]

[tool.ruff.lint.per-file-ignores]
"__init__.py" = ["F401"]

[tool.ruff.lint.pydocstyle]
convention = "google"
```

- Formatting via black

## Testing
- Testing via pytest - right now this is very basic and only tests the installation of the modules and if the GUI can be opened. This is implmented with github actions.

## Documentation
- Documentation via sphinx in the nqrduckumentation repository. 

## Deployment
- Deployment via  PyPi. This happens on creation of a new version tag (meaning it starts with a v).
Deployment is done for every single module in the NQRduck project.
- For modules with Cython there are wheels for aarch64 and x86_64 (manylinux and musllinux). This can take quite long to build (up to 6h).

## TODO
- The testing has to be significantly improved. Especially stuff like loading and saving of files has to be automatically tested before deployment. Additionally, signal processing stuff is easy to test and therefore should be implemented soon. 

- Pre-commit hooks should be added to the project. This would make sure that the code is always linted and formatted correctly. The according files should be added to this repository.

## Notes
- Total size of the development environment ist about 700MB.