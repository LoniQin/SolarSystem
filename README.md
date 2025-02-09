# Solar System SceneKit Demo

This project is a 3D Solar System simulation built using Apple's SceneKit framework. It features the Sun and nine planets (including Pluto) with realistic orbital mechanics and rotation. Each planet orbits the Sun at different speeds and distances, and rotates on its own axis. The project is designed to be simple, educational, and visually engaging.

## Features

- **Sun**: A glowing sphere with an omnidirectional light source.
- **Planets**: Nine planets (Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune, and Pluto) with unique sizes, colors, and orbital/rotation periods.
- **Orbital Mechanics**: Planets orbit the Sun at different speeds and distances.
- **Rotation**: Planets rotate on their own axes while orbiting.
- **Interactive Highlighting**: Click or tap on a planet to highlight it briefly.
- **Camera View**: A fixed camera provides a view of the entire solar system.

## Requirements

- **Platform**: macOS or iOS
- **Xcode**: Version 13 or later
- **Swift**: Version 5 or later
- **SceneKit**: Built-in framework for 3D rendering

## Setup

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/LoniQin/SolarSystem
   cd solar-system-scenekit
   ```

2. **Open the Project**:
   - Open the `SolarSystem.xcodeproj` file in Xcode.

3. **Run the Project**:
   - Select the appropriate target (macOS or iOS).
   - Build and run the project using the `Run` button (⌘R).

4. **Interact with the Solar System**:
   - On macOS, click on a planet to highlight it.
   - On iOS, tap on a planet to highlight it.
   - Observe the planets orbiting the Sun and rotating on their axes.

## Code Overview

The project consists of a single `GameController` class that sets up the SceneKit scene, creates the Sun and planets, and handles interactions. Key components include:

- **Sun**: Created as a glowing sphere with an attached light source.
- **Planets**: Programmatically generated with unique properties (size, color, distance, orbital period, and rotation period).
- **Orbital Mechanics**: Achieved using `SCNAction` to rotate orbital nodes around the Sun.
- **Rotation**: Achieved using `SCNAction` to rotate planets on their axes.
- **Highlighting**: Implemented using `SCNTransaction` to change the emission color of a planet's material.

## Customization

You can customize the Solar System by modifying the `planets` array in the `setupSolarSystem()` method. Each planet is defined with the following properties:

- `name`: The name of the planet.
- `radius`: The size of the planet.
- `distance`: The distance from the Sun.
- `color`: The color of the planet.
- `orbitalPeriod`: The time it takes to complete one orbit around the Sun.
- `rotationPeriod`: The time it takes to complete one rotation on its axis.

Example:
```swift
Planet(name: "Earth", radius: 0.7, distance: 12, color: .blue, orbitalPeriod: 12, rotationPeriod: 1)
```


## Videos

<video width="560" height="315" src="solar_system_animation.mov" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></video>

## Contributing

Contributions are welcome! If you'd like to improve the project, please open an issue or submit a pull request.
