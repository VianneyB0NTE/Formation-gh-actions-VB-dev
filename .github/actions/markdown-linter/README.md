# Markdown Linter Action

A reusable GitHub Action that lints markdown files and creates/updates PR comments with the results.

## Features

- 🔍 **Lint markdown files** using markdownlint-cli
- 💬 **Automated PR comments** with linting results
- ⚙️ **Configurable** file patterns, directories, and severity levels
- 🎯 **Smart commenting** - creates or updates existing comments
- 📊 **Detailed output** with expandable results
- 🛡️ **Optional failure** on errors

## Usage

### Basic Usage

```yaml
- name: Lint Documentation
  uses: ./.github/actions/markdown-linter
  with:
    directory: 'docs'
```

### Advanced Usage

```yaml
- name: Lint Documentation with Custom Config
  uses: ./.github/actions/markdown-linter
  with:
    directory: 'docs/section1'
    config-file: '.markdownlint.json'
    files-pattern: '**/*.md'
    comment-title: '📚 Documentation Linting'
    fail-on-error: 'true'
    severity: 'error'
```

### Matrix Strategy Example

```yaml
jobs:
  lint-docs:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        section: [section1, section2, section3, section4]
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Lint ${{ matrix.section }}
        uses: ./.github/actions/markdown-linter
        with:
          directory: 'docs/${{ matrix.section }}'
          comment-title: '📖 Linting Results - ${{ matrix.section }}'
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `directory` | Directory to lint | ✅ | - |
| `config-file` | Path to markdownlint config file | ❌ | `''` |
| `severity` | Minimum severity level | ❌ | `'warning'` |
| `comment-title` | Title for PR comment | ❌ | `'📖 Markdown Linting Results'` |
| `fail-on-error` | Fail action if errors found | ❌ | `'false'` |
| `files-pattern` | File pattern to lint | ❌ | `'*.md'` |

## Outputs

| Output | Description |
|--------|-------------|
| `results-file` | Path to linting results file |
| `has-errors` | Whether errors were found |
| `comment-id` | ID of created/updated comment |

## Required Permissions

Your workflow needs these permissions:

```yaml
permissions:
  contents: read
  pull-requests: write
  issues: write
```

## Configuration File

Create a `.markdownlint.json` file to customize linting rules:

```json
{
  "MD013": {
    "line_length": 120
  },
  "MD033": false,
  "MD041": false
}
```

## Example Workflow

```yaml
name: Lint Documentation
on:
  pull_request:
    paths: ['docs/**']

permissions:
  contents: read
  pull-requests: write
  issues: write

jobs:
  lint-markdown:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        section: [section1, section2, section3, section4]
      fail-fast: false
    
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Lint ${{ matrix.section }}
        uses: ./.github/actions/markdown-linter
        with:
          directory: 'docs/${{ matrix.section }}'
          comment-title: '📖 Linting - ${{ matrix.section }}'
          fail-on-error: 'true'
```

## Error Handling

The action handles various scenarios gracefully:

- ✅ **No files found**: Reports success
- ✅ **Missing directory**: Creates informative message
- ✅ **Permission issues**: Falls back to creating new comments
- ✅ **Config file errors**: Uses default configuration

## Benefits

- **Reusable**: Use across multiple repositories
- **Efficient**: Matrix strategy for parallel processing  
- **User-friendly**: Clear, formatted PR comments
- **Flexible**: Configurable inputs and outputs
- **Reliable**: Comprehensive error handling