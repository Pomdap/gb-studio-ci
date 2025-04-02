
# GB Studio CI

A Docker image equipped with a powerful toolset to streamline the export process of GB Studio games.

## Supported Tags and Corresponding `Dockerfile` Links

This image is available in multiple versions to support different GB Studio releases. You can find the available tags below:

- `unstable`
- [`4.1.3`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile), [`latest`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`4.1.2`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`4.1.1`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`4.1.0`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`4.0.2`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`4.0.1`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`4.0.0-rc.2`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`4.0.0-rc.1`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`4.0.0-beta2`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`4.0.0-beta1`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`3.2.1`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`3.2.0`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`3.1.0`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`3.0.3`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`3.0.2`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`3.0.1`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)
- [`3.0.0`](https://github.com/Pomdap/gb-studio-ci/blob/main/Dockerfile)

## What is GB Studio CI?

GB Studio CI is a Docker image designed to simplify the Continuous Integration (CI) process for GB Studio projects. It provides a pre-configured environment with the necessary tools to automate game exports, ensuring a seamless pipeline for developers who wish to distribute their games effortlessly.

With this image, you can:

- Automate the export of GB Studio games in multiple formats.
- Integrate the export process into a GitHub Actions workflow.

## How to Use This Image

<!-- 
### Clone the Example Project

To get started quickly, clone the example project from the [gb-studio-ci-example](https://github.com/Pomdap/gb-studio-ci-example) repository.

```sh
git clone https://github.com/Pomdap/gb-studio-ci-example.git
```

This repository contains multiple GitHub Actions workflows that automate various aspects of the export and deployment process. For more details, check out the complete workflow setup in the [example repository](https://github.com/Pomdap/gb-studio-ci-example).
 -->
### Use it in your own GitHub Actions

You can integrate this Docker image into your GitHub Actions workflow. Below is an example configuration for exporting a ROM using GB Studio CI:

```yaml
export-rom:
  runs-on: ubuntu-latest
  container:
    image: pomdap/gb-studio-ci:3.1.0
  steps:
    - uses: actions/checkout@v4
    - run: gb-studio-cli make:rom "path/to/project.gbsproj" "out/game.gb"
    - uses: actions/upload-artifact@v4
      with:
        name: "game.gb"
        path: "out/game.gb"
```

## Included Tools

<!-- This image comes with several tools pre-installed, including GB Studio CLI, which helps facilitate the game export process. This enables the automation of builds, making it easier to integrate the process into a CI/CD pipeline. By using this pre-configured environment, developers can quickly set up their pipeline, saving both time and effort. The pre-configured environment ensures consistent results across different systems and environments, improving the efficiency and reliability of the game export process. With this approach, teams can focus more on development and less on setting up the infrastructure, leading to a smoother and more streamlined workflow. -->

### GB Studio CLI

GB Studio CLI is a command-line tool that allows users to export GB Studio projects into various formats without using the graphical interface. This tool is precompiled and included in the Docker image, enabling automated builds in a CI/CD pipeline without requiring manual installation.

#### Export

GB Studio CLI allows you to export your game in various formats from the command line.

Example usage, export your project as a rom file:

```bash
gb-studio-cli make:rom "path/to/project.gbsproj" "out/game.gb"
```

You can find other usages in the [GB Studio readme](https://github.com/chrismaltby/gb-studio?tab=readme-ov-file#cli-examples).

#### Compatibility

| GB Studio Version | ROM Export | Web Export | Pocket Export |
| ----------------- | ---------- | ---------- | ------------- |
| ≥ 3.2.0           | ✅          | ✅          | ✅             |
| < 3.1.0           | ✅          | ✅          | ❌             |

## Contributing

Contributions are welcome! If you encounter issues or have feature requests, feel free to open an issue or submit a pull request on the [GitHub repository](https://github.com/Pomdap/gb-studio-ci).

## License

This project is licensed under the CC0 1.0 Universal License. See the [LICENSE](https://github.com/Pomdap/gb-studio-ci/blob/main/LICENSE) file for details.
