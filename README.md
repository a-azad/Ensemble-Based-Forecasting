# Ensemble-Based Forecasting
* Application of the well-known Kalman Filter in operation in the energy sector.
* Employs Ensemble-based algorithm to link monitored data with the underlying data models (multi-physics simulation) in order to improve production Forecasting.
* The paper was published [here](https://www.onepetro.org/journal-paper/SPE-146898-PA).


### Before optimization and Forecasting
![alt text](/img/before.jpg)

### After monitoring and data modelling
![alt text](/img/after.jpg)

# Abstract
In situ thermal methods such as steam-assisted gravity drainage (SAGD) and cyclic steam stimulation (CSS) are widely employed in oil sand reservoirs. The physics of such thermal processes is generally well understood, and it has been shown that rock properties are highly influenced by the geomechanical behaviour of the reservoir during these recovery processes. Geomechanics improves the process dynamically, and its response can depict the progress of production within a reservoir. However, the potential of geomechanical monitoring for application to closed-loop reservoir optimization is not usually practiced. With increased implementation of highly instrumented wells and communication technologies providing real-time monitoring data from different sources, combining available data into reservoir-geomechanical simulations would improve updating numerical models and prediction process. This research explores effective uses of geomechanical observation data for history matching and types of geomechanical observation sources adequate for thermal recovery. The ensemble Kalman filter (EnKF), combined with an iterative geomechanical coupled simulator, has been chosen as the data assimilation algorithm to update the model continuously based on geomechanical observations. The results show that considering geomechanical modelling and observation improves the history matching process when geomechanics is an issue.
