% The name of the module
-module(drop).
% which functions are available to anything outside of this module
-export([fall_velocity/1, mps_to_mph/1, mps_to_kph/1]).

% Calculate the falling velocity based on distance (result in Metres per second)
fall_velocity(Distance) -> math:sqrt(2 * 9.8 * Distance).

% Convert MPS to MPH
mps_to_mph(Mps) -> 2.23693629 * Mps.

% Convert MPS to KPH
mps_to_kph(Mps) -> 3.6 * Mps.
