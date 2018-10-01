#!/bin/bash
# GPS NMEA parsing tool from file
while read -r line
do
string=$(echo $line | cut -d* -f 1)
old_IFS="$IFS"
IFS=','
read -a field <<<"$string"
IFS="$old_IFS"
if [[ "${field[0]}" =~ "GGA" ]]; then
	UTC=$(echo ${field[1]} | fold -w2 | paste -sd':' -)
	LATITUDE="${field[2]} ${field[3]}"
	LONGTITUDE="${field[4]} ${field[5]}"
	SATNUM=${field[7]}
	HORDIL=${field[8]}
	ALTITUDE=${field[9]}
	SEALVL=${field[11]}
	echo "Global Positioning System Fixed Data"
	echo "Fix taken at: $UTC UTC"
	echo "Number of satellites used: $SATNUM"
	echo "Horizontal dilution of precision: $HORDIL"
	echo "Coordinates: $LATITUDE $LONGTITUDE"
	echo "Altitude: $ALTITUDE meters"
	echo "Sea level: $SEALVL meters"
	echo "---------------------------------------------------------"
elif [[ "${field[0]}" =~ "RMC" ]]; then
	UTC=$(echo ${field[1]} | fold -w2 | paste -sd':' -)
	LATITUDE="${field[3]} ${field[4]}"
	LONGTITUDE="${field[5]} ${field[6]}"
	SPEED=${field[7]}
	# 1 knot equals to 1.852 km/h
	HDG=${field[8]} #heading of track in degrees
	MAGNETVAR="${field[10]} ${field[11]}"
	DATE=$(echo ${field[9]} | fold -w2 | paste -sd'/' -)
	echo "Recommended Minimum Specific GNSS Data"
	echo "Fix taken at: $UTC UTC, $DATE"
	echo "Coordinates: $LATITUDE $LONGTITUDE"
	echo "Ground speed: $SPEED knots, heading $HDG"
	echo "Magnetic declination: $MAGNETVAR"
	echo "---------------------------------------------------------"
elif [[ "${field[0]}" =~ "GPGSV" ]]; then
	SENTENCES=${field[1]}
	SENTENCENO=${field[2]}
	SATVIEW=${field[3]}
	#first satellite
	SATAID=${field[4]}
	SATAELEVATION=${field[5]}
	SATAAZIMUTH=${field[6]}
	SATASNR=${field[7]}
	#second satellite
	SATBID=${field[8]}
	SATBELEVATION=${field[9]}
	SATBAZIMUTH=${field[10]}
	SATBSNR=${field[11]}
	#third satellite
	SATCID=${field[12]}
	SATCELEVATION=${field[13]}
	SATCAZIMUTH=${field[14]}
	SATCSNR=${field[15]}
	#fourth satellite
	SATDID=${field[16]}
	SATDELEVATION=${field[17]}
	SATDAZIMUTH=${field[18]}
	SATDSNR=${field[19]}
	echo "+-------------------------------------------------------+"
	echo "| GPS satellites in view: $SATVIEW			$SENTENCENO/$SENTENCES	|"
	echo "+-------------------------------------------------------+"
	echo "| Satellite ID		|$SATAID	|$SATBID	|$SATCID	|$SATDID	|"
	echo "| Elevation		|$SATAELEVATION	|$SATBELEVATION	|$SATCELEVATION	|$SATDELEVATION	|"
	echo "| Azimuth		|$SATAAZIMUTH	|$SATBAZIMUTH	|$SATCAZIMUTH	|$SATDAZIMUTH	|"
	echo "| SNR (dBHz)		|$SATASNR	|$SATBSNR	|$SATCSNR	|$SATDSNR	|"
	echo "+-------------------------------------------------------+"
elif [[ "${field[0]}" =~ "GLGSV" ]]; then
	SENTENCES=${field[1]}
	SENTENCENO=${field[2]}
	SATVIEW=${field[3]}
	#first satellite
	SATAID=${field[4]}
	SATAELEVATION=${field[5]}
	SATAAZIMUTH=${field[6]}
	SATASNR=${field[7]}
	#second satellite
	SATBID=${field[8]}
	SATBELEVATION=${field[9]}
	SATBAZIMUTH=${field[10]}
	SATBSNR=${field[11]}
	#third satellite
	SATCID=${field[12]}
	SATCELEVATION=${field[13]}
	SATCAZIMUTH=${field[14]}
	SATCSNR=${field[15]}
	#fourth satellite
	SATDID=${field[16]}
	SATDELEVATION=${field[17]}
	SATDAZIMUTH=${field[18]}
	SATDSNR=${field[19]}
	echo "+-------------------------------------------------------+"
	echo "| GLONASS satellites in view: $SATVIEW		$SENTENCENO/$SENTENCES	|"
	echo "+-------------------------------------------------------+"
	echo "| Satellite ID		|$SATAID	|$SATBID	|$SATCID	|$SATDID	|"
	echo "| Elevation		|$SATAELEVATION	|$SATBELEVATION	|$SATCELEVATION	|$SATDELEVATION	|"
	echo "| Azimuth		|$SATAAZIMUTH	|$SATBAZIMUTH	|$SATCAZIMUTH	|$SATDAZIMUTH	|"
	echo "| SNR (dBHz)		|$SATASNR	|$SATBSNR	|$SATCSNR	|$SATDSNR	|"
	echo "+-------------------------------------------------------+"
fi
#sleep 0
done <"$1"
