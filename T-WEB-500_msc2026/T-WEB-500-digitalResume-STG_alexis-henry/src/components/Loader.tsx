import React, { useState } from "react";
import LoaderImage from "@/components/LoaderImage";
import Ball from "@/components/Ball";
import { loader } from "@/services/constants";
import "@/styles/components/Loader.scss";

type Loader = {
  setShowLoader: React.Dispatch<React.SetStateAction<boolean>>;
}

export default function Loader(props: Loader) {
  const [direction, setDirection] = useState<string>("down");
  const [step, setStep] = useState<number>(1);
  const [filename, setFilename] = useState<string>("1");
  const [isFinished, setIsFinished] = useState<boolean>(false);
  const [scrolledAt, setScrolledAt] = useState<number>(0);
  const [showTutorial, setShowTutorial] = useState<boolean>(true);

  const updateFrame = (s: number): void => {
    setFilename(s.toString());
    setStep(s);
  };

  const onWheel = (e: React.WheelEvent<HTMLDivElement>): void => {
    if (e.timeStamp !== 0 && e.timeStamp - scrolledAt < loader.delay) return;
    setScrolledAt(e.timeStamp);
    let d: number = e.deltaY,
      s: number = parseInt(filename);
    if (d > 0 && s < loader.maxStep) {
      s++;
      setDirection("down");
    } else if (d < 0 && s > loader.minStep) {
      s--;
      setDirection("up");
    }
    if (s !== parseInt(filename) && s <= loader.maxStep) updateFrame(s);
    if (s === loader.maxStep) {
      setIsFinished(true);
      setTimeout(() => {
        props.setShowLoader(false);
      }, 1500);
    }
  };

  return (
    <>
      <div className={"tutorial" + (!showTutorial ? " disappear" : "")}>
        <h1>Welcome!</h1>
        <p>You will need to scroll down to load the page.</p>
        <button onClick={(): void => setShowTutorial(false)}>Start</button>
      </div>
      <div
        className={"loader" + (isFinished ? " finished" : "")}
        onWheel={isFinished ? (): void => {} : onWheel}
      >
        <div className="absolute-container">
          <LoaderImage filename={filename} />
          <Ball step={step} direction={direction} />
        </div>
      </div>
    </>
  );
}
