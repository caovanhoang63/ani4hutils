'use client'

import ReactPlayer from "react-player";
import {ChangeEvent, useEffect, useRef, useState} from "react";
import {OnProgressProps} from "react-player/types/base";
import {ExpandIcon, PauseIcon, PlayIcon, ShrinkIcon, Volume2, VolumeX, SkipForward, CircleGauge, RotateCcw, RotateCw} from "lucide-react";
import {formatTime} from "@/utils/format";

export default function Player() {
    const player = useRef<ReactPlayer>(null);
    const playerWrapper = useRef<HTMLDivElement  | null>(null);
    const [levels, setLevels] = useState([]);
    const [playing, setPlaying] = useState(false);
    const [progress, setProgress] = useState(0);
    const [duration, setDuration] = useState(0);
    const [isFullscreen, setIsFullscreen] = useState(false);
    const [muted, setMuted] = useState(false)
    const [playedTime, setPlayedTime] = useState(0);
    const [loaded, setLoaded] = useState(0);
    const [playbackRate, setPlaybackRate] = useState(1);
    const [showControls, setShowControls] = useState(true);
    const hideControlsTimeout = useRef<NodeJS.Timeout | null>(null);
    const [selectedLevel, setSelectedLevel] = useState(-1);
    const handleReady = () => {
        const hls = player.current?.getInternalPlayer("hls");
        if (!player.current || !hls ) return
        if (hls && hls.levels) {
            setLevels(hls.levels);
            setSelectedLevel(hls.currentLevel)
           hls.currentLevel = -1;
        }
        hls.on("hlsLevelSwitched", (event: string, data: { level: number }) => {
            setSelectedLevel(data.level);
        });
        //setDuration(player.current.getDuration());
    };
    const onChangeBitrate = (e: ChangeEvent<HTMLSelectElement>) => {
        const selectedLevels = e.target.value;
        const hls = player.current?.getInternalPlayer("hls");
        try{
            if (hls) {
                hls.currentLevel = Number(selectedLevels);
                setSelectedLevel(Number(selectedLevels));
            }
        }catch (e){
            console.log(e)
        }

    };
    const togglePlay = () => {
        setPlaying(!playing);
    };

    const handleProgress = (state:  OnProgressProps) => {
        try{
            const hls = player.current?.getInternalPlayer("hls");
            const currentLevel = hls?.currentLevel;

            console.log("Resolution:", hls?.levels[currentLevel].height + "p");
            console.log("Bitrate:", hls?.levels[currentLevel].bitrate / 1000 + " kbps");
            console.log("loaded", state.loadedSeconds)
            console.log("played", state.playedSeconds)
            setProgress(state.played);
            setLoaded(state.loaded);
            setPlayedTime(state.playedSeconds)
            //console.log(state.played)
        }catch (e){
            console.log(e)
        }

    };
    const toggleFullscreen = () => {
        if (!isFullscreen) {
            playerWrapper.current?.requestFullscreen(); // Vào fullscreen
            setIsFullscreen(true);
        } else {
            document.exitFullscreen().then();
            setIsFullscreen(false);
        }
    };

    const handleSeek = (e : ChangeEvent<HTMLInputElement>) => {
        const seekValue = parseFloat(e.target.value);
        setProgress(seekValue);
        player.current?.seekTo(seekValue);
    };

    const toggleMute = () =>{
        setMuted(!muted);
    }

    const handleDuration = (duration:number) =>{
        setDuration(duration)
    }

    const handleMouseMove = () => {
        setShowControls(true);
        if (hideControlsTimeout.current) {
            clearTimeout(hideControlsTimeout.current);
        }
        hideControlsTimeout.current = setTimeout(() => {
            setShowControls(false);
        }, 3000);
    };

    const handleMouseLeave = () => {
        if (hideControlsTimeout.current) {
            clearTimeout(hideControlsTimeout.current);
        }
        hideControlsTimeout.current = setTimeout(() => {
            setShowControls(false);
        }, 3000);
    };
    const rewind5Seconds = () => {
        if (!player.current) return;
        const currentTime = player.current.getCurrentTime();
        const newTime = Math.max(0, currentTime - 5);
        player.current.seekTo(newTime, "seconds");
        setPlayedTime(newTime);
        setProgress(newTime / duration);
    };

    const fastForward5Seconds = () => {
        if (!player.current) return;
        const currentTime = player.current.getCurrentTime();
        const newTime = Math.min(duration, currentTime + 5);
        player.current.seekTo(newTime, "seconds");
        setPlayedTime(newTime);
        setProgress(newTime / duration);
    };
    useEffect(() => {
        return () => {
            if (hideControlsTimeout.current) {
                clearTimeout(hideControlsTimeout.current);
            }
        };
    }, []);
    return (
        <div className="player-wrapper" ref={playerWrapper} onMouseMove={handleMouseMove} onMouseLeave={handleMouseLeave}>
            <ReactPlayer
                ref={player}
                url="https://demo.unified-streaming.com/k8s/features/stable/video/tears-of-steel/tears-of-steel.ism/.m3u8"
                playing={playing}
                muted={muted}
                controls={false}
                config={{
                    file: {
                        forceHLS: true,
                        hlsOptions:{
                            maxBufferLength:30,
                            maxMaxBufferLength: 180,
                            liveSyncDuration: 15,
                            lowLatencyMode:true,
                        }
                    },
                }}
                onDuration={handleDuration}
                playbackRate={playbackRate}
                onReady={handleReady}
                onProgress={handleProgress}
                width="100%"
                height="100%"
            />
            <div className={`absolute bottom-0 left-0 right-0 px-4 pb-2 pt-4 flex items-center text-white
            gap-5 justify-between w-full bg-base-100 transition-opacity duration-500
            ${showControls || !playing ? "opacity-50":"opacity-0 pointer-events-none"}
            `}>
                <input type="range" min="0" step={"any"} max="1" value={loaded} readOnly={true}
                       className="absolute top-[-4] left-0 right-0 w-full
                       range [--range-thumb:var(--color-white)]
                       [--range-thumb-size:calc(var(--size-selector,0.25rem)*2)]
                       [--range-bg:gray]
                        "/>

                <input type="range" min="0" step={"any"} max="1" onChange={handleSeek} value={progress}
                       className="absolute top-[-4] left-0 right-0 w-full range-primary
                       range [--range-thumb:var(--color-primary)] cursor-pointer
                       [--range-thumb-size:calc(var(--size-selector,0.25rem)*2)]
                       [--range-bg:transparent]
                        "/>

                <button className="cursor-pointer hover:text-primary" onClick={togglePlay}>{playing ? <PauseIcon size={20}/> : <PlayIcon size={20}/>}</button>
                <button  onClick={toggleMute} className="cursor-pointer hover:text-primary" >
                    {muted ? <VolumeX size={20}/> : <Volume2 size={20}/> }
                </button>
                <span className="text-sm ">{formatTime(playedTime)} / {formatTime(duration)}</span>
                <div className="flex-1"></div>
                <button className="cursor-pointer hover:text-primary" onClick={rewind5Seconds} >
                    <RotateCcw size={20}/>
                </button>
                <button className="cursor-pointer hover:text-primary"  onClick={fastForward5Seconds} >
                    <RotateCw size={20}/>
                </button>
                <button className="cursor-pointer hover:text-primary"  >
                    <SkipForward size={20}/>
                </button>
                <div className="relative flex justify-center items-center">
                    <div className="dropdown dropdown-top p-0">
                        <div tabIndex={0} role="button" className="btn hover:text-primary p-0"><CircleGauge size={20}/></div>
                        <ul tabIndex={0} className="dropdown-content menu bg-black rounded z-1  p-2">
                            {[0.25 ,0.5, 0.75, 1, 1.25, 1.5, 2].map(rate => (
                                <li
                                    key={rate}
                                    className={`cursor-pointer px-2 py-1 hover:bg-white/10 rounded ${rate === playbackRate ? 'font-bold text-primary' : ''}`}
                                    onClick={() => {
                                        setPlaybackRate(rate);
                                    }}
                                >
                                    {rate}x
                                </li>
                            ))}
                        </ul>
                    </div>
                </div>
                <select
                    className="cursor-pointer hover:border-primary bg-base-100 border border-white px-1 text-sm rounded flex justify-center items-center pb-1"
                onChange={onChangeBitrate}
                value={selectedLevel}
                >
                    <option value={-1}>Auto</option>
                {levels.length > 0 ? (
                    levels.map((level: { height: number }, id) => (
                        <option key={id} value={id}>
                            {level.height}p
                        </option>
                    ))
                ) : (
                    <option>Loading...</option>
                )}
            </select>
                <button onClick={toggleFullscreen} className="cursor-pointer hover:text-primary" >
                    {isFullscreen ? <ShrinkIcon size={20}/> :<ExpandIcon size={20}/>}
                </button>
            </div>
        </div>
    );
};
