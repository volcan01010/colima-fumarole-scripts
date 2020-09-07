# colima-fumarole-scripts

> Matlab scripts used atmospheric corrections in Colima fumarole monitoring paper

These scripts were used to create figures for the following paper:

+ Stevenson JA, Varley N (2008) _Fumarole monitoring with a handheld infrared camera: Volcán de Colima, Mexico, 2006-2007._ Journal of Volcanology and Geothermal Research 177:911–924.  [https://doi.org/10.1016/j.jvolgeores.2008.07.003](https://doi.org/10.1016/j.jvolgeores.2008.07.003)

They are published here in case they are useful to others.
I no longer have access to Matlab and haven't used it for over 10 years, so
I have been unable to test or update them.
They are deposited as they were used to create the paper.
Not all the files may be required.

I'm not sure which Matlab version is required, but it was current in 2008.

Note: although the files here are called Figure 2, in the actual published paper they
became Figure 3 and Figure 4!!!

Happy coding!


### Atmospheric corrections of fumarole temperatures

I think that all the functions required to make atmospheric corrections are in
[apparent_temperature_models.m](apparent_temperature_models.m)
From what I can remember, the conversion works something like:

+ Convert temperature as recorded by infrared camera into a radiance using an
  empirical formula derived from camera software (temp2rad)
+ Modify the observed radiance to an emitted radiance taking transmissivity,
  distance and pixel area into account
+ The transmissivity function was derived empirically from data produced via
  the MODTRAN software
+ Convert the emitted radiance back to a temperature (rad2temp)

See **Models of fumarole temperatures** section of the paper for details.

### Licence

These files are published under the [MIT licence](LICENSE) - you can use them how you
want as long as you acknowlege this repository and publication as the source.
