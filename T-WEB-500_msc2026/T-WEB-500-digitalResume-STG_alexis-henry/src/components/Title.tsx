import "@/styles/components/Title.scss";

export default function Title(props: { content: string }) {
  return (
    <div className="page-title">
      <h1>
        {props.content}
        <div className="underline"></div>
      </h1>
    </div>
  );
}
