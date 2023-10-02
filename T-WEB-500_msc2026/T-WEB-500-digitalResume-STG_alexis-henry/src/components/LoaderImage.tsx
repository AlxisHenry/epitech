export default function LoaderImage(props: { filename: string }): JSX.Element {
  return (
    <div className="loader-image">
      <div className="shadow"></div>
      <img
        src={`loader/player/${props.filename}.png`}
        alt={`Image ${props.filename}`}
      />
    </div>
  );
}
